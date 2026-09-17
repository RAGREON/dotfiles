-- Use PowerShell 7 (pwsh) if installed, otherwise fall back to Windows PowerShell (powershell)
local powershell_exe = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

vim.opt.shell = powershell_exe
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
