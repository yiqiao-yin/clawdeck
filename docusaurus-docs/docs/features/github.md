# GitHub Integration

Seamless repository management, commit operations, and pull request workflows directly from Clawdeck CLI.

## Features

- **Authentication** - Automatic login with GitHub tokens
- **Commit & Push** - Stage, commit, and push changes
- **Branch Management** - Create, checkout, and merge branches
- **Pull Requests** - Create PRs with generated descriptions
- **Repository Operations** - Clone, fork, and manage repositories

## Setup

Set your GitHub token:
```bash
export GH_TOKEN=ghp_your_github_token
# or
export GITHUB_TOKEN=ghp_your_github_token
```

## Usage Examples

### Commit Changes
```
You: Commit my changes with a good message

Clawdeck: [Analyzes changes and creates descriptive commit]
✓ Added 3 files, modified 2 files
✓ Generated commit: "feat: Add authentication middleware and user routes"
✓ Pushed to origin/main
```

### Create Pull Request
```
You: Create a PR for this feature branch

Clawdeck: [Creates PR with auto-generated description]
✓ Pull Request created: #42
📋 Title: "Add user authentication system"
🔗 URL: https://github.com/user/repo/pull/42
```

### Branch Operations
```
You: Create a new feature branch for user profiles

Clawdeck:
✓ Created branch: feature/user-profiles
✓ Switched to new branch
✓ Ready for development
```

For detailed examples, see [Usage Examples](../usage/use-cases.md#github-integration-examples).