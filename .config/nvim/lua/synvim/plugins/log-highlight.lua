-- SynVim Log Highlight Plugin
-- Syntax highlighting for log files

return {
  "fei6409/log-highlight.nvim",
  event = "BufRead *.log",
  
  opts = {
    extension = "log",
    
    filename = {
      "syslog",
      "messages",
      "kern.log",
    },
    
    pattern = {
      "/var/log/.*",
      ".*%.log$",
    },
    
    keyword = {
      error = { "ERROR", "FATAL", "CRITICAL", "FAIL" },
      warning = { "WARN", "WARNING", "CAUTION" },
      info = { "INFO", "INFORMATION", "NOTE" },
      debug = { "DEBUG", "TRACE", "VERBOSE" },
      pass = { "SUCCESS", "PASS", "OK", "DONE" },
    },
  },
}
