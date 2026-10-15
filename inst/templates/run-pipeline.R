# Run the targets pipeline and send a completion notification.
#
# Created by levinmisc::populate_targets_proj(). The "Run pipeline" editor task
# runs this script with `Rscript .run-pipeline.R`; it can also be run directly.
#
# The notification contains only the status, elapsed time, target counts, and
# the names of errored targets. It never includes error messages, warnings, or
# target values, because R errors can echo data values and the notification
# leaves the cluster. The full error is printed in the terminal.
#
# Notifications are configured per user in ~/.Renviron, never in the project:
#   LEVINMISC_NOTIFY=slack            # or ntfy; unset or none = terminal only
#   LEVINMISC_SLACK_WEBHOOK=https://hooks.slack.com/services/...
#   LEVINMISC_NTFY_URL=https://ntfy.sh/your-hard-to-guess-topic
#   LEVINMISC_NOTIFY_START=true       # optional: also notify when a run starts
#
# Sending uses the curl command-line tool, so no R packages beyond targets are
# needed. A failed notification prints a warning and never changes the exit
# status, which reflects only the pipeline result.

notify <- function(text, failed = FALSE) {
  channel <- tolower(Sys.getenv("LEVINMISC_NOTIFY", "none"))
  if (channel %in% c("", "none")) {
    return(invisible(FALSE))
  }

  # Mask anything shaped like a PMBB ID, as a final safeguard
  text <- gsub("([Pp][Mm])[Bb][Bb][ _-]?[0-9]{6,}", "\\1************", text)

  if (!nzchar(Sys.which("curl"))) {
    warning("curl is not on PATH; notification skipped", call. = FALSE)
    return(invisible(FALSE))
  }

  args <- switch(channel,
    slack = {
      url <- Sys.getenv("LEVINMISC_SLACK_WEBHOOK")
      escaped <- gsub("\n", "\\\\n", gsub("\"", "\\\\\"", gsub("\\\\", "\\\\\\\\", text)))
      c("-H", shQuote("Content-type: application/json"),
        "--data", shQuote(sprintf("{\"text\": \"%s\"}", escaped)),
        shQuote(url))
    },
    ntfy = {
      url <- Sys.getenv("LEVINMISC_NTFY_URL")
      c("-H", shQuote("Title: targets pipeline"),
        if (failed) c("-H", shQuote("Tags: warning")),
        "--data", shQuote(text),
        shQuote(url))
    },
    {
      warning("Unknown LEVINMISC_NOTIFY value '", channel, "'; use slack, ntfy, or none", call. = FALSE)
      return(invisible(FALSE))
    }
  )
  if (!nzchar(url)) {
    warning("No URL set for LEVINMISC_NOTIFY=", channel, "; notification skipped", call. = FALSE)
    return(invisible(FALSE))
  }

  status <- tryCatch(
    system2("curl", c("-sS", "--max-time", "20", "-o", "/dev/null", "-X", "POST", args)),
    error = function(e) 1L
  )
  if (!identical(as.integer(status), 0L)) {
    warning("Notification failed (curl exit status ", status, ")", call. = FALSE)
  }
  invisible(identical(as.integer(status), 0L))
}

project <- basename(getwd())
started <- Sys.time()

if (tolower(Sys.getenv("LEVINMISC_NOTIFY_START")) == "true") {
  notify(sprintf("targets pipeline started in %s.", project))
}

result <- tryCatch(
  {
    targets::tar_make()
    NULL
  },
  error = function(e) e
)
failed <- inherits(result, "error")
elapsed <- format(round(difftime(Sys.time(), started), 1))

# Count targets by their status in this run. Reading progress can itself fail,
# for example when the pipeline stopped before any target ran.
progress <- tryCatch(targets::tar_progress(), error = function(e) NULL)
count_status <- function(status) {
  if (is.null(progress)) 0L else sum(progress$progress == status)
}
errored <- if (is.null(progress)) character(0) else progress$name[progress$progress == "errored"]

lines <- c(
  sprintf("targets pipeline %s in %s after %s.",
          if (failed) "FAILED" else "completed", project, elapsed),
  sprintf("Completed: %d, skipped: %d, errored: %d, canceled: %d.",
          count_status("completed"), count_status("skipped"),
          count_status("errored"), count_status("canceled"))
)
if (length(errored) > 0) {
  shown <- utils::head(errored, 10)
  more <- if (length(errored) > 10) sprintf(" (and %d more)", length(errored) - 10) else ""
  lines <- c(lines, sprintf("Errored targets: %s%s", paste(shown, collapse = ", "), more))
}
summary_text <- paste(lines, collapse = "\n")

cat("\n", summary_text, "\n", sep = "")
notify(summary_text, failed = failed)

if (failed) {
  message("\nError from tar_make(): ", conditionMessage(result))
  quit(save = "no", status = 1)
}
