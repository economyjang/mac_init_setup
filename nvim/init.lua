-- 시스템 클립보드 연동 (pbcopy provider 사용)
vim.opt.clipboard = "unnamedplus"

-- 마우스 드래그 놓으면 자동 복사 (tmux shell 동작과 통일)
vim.keymap.set("x", "<LeftRelease>", '"+y', { silent = true })
