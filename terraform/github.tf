resource "github_repository" "main" {
  name       = var.github_repository_name
  visibility = var.github_repository_visibility
  auto_init  = true
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = var.github_default_branch
}
