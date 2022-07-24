local installer_status_ok, nvim_lsp_installer = pcall(require, 'nvim-lsp-installer')
if not installer_status_ok then
  return
end

nvim_lsp_installer.setup({
    automatic_installation = true,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})
