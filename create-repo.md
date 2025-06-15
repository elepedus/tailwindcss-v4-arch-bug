# Steps to Create and Push the Repository

## 1. Create Repository on GitHub

Go to https://github.com/new and create a new repository with:
- Repository name: `tailwindcss-v4-arch-bug`
- Description: `Minimal reproduction of Tailwind CSS v4 architecture-specific CSS generation bug`
- Public repository
- DO NOT initialize with README, .gitignore, or license

## 2. Push to GitHub

After creating the repository, run these commands in your terminal:

```bash
cd /Users/elepedus/Developer/personal/wowsy/temp/tailwindcss-v4-arch-bug

# Add the remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/tailwindcss-v4-arch-bug.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## 3. Update Issue Drafts

After pushing, update the issue drafts to replace `[yourusername]` with your actual GitHub username in:
- `tailwindcss-issue-draft.md`
- `phoenix-issue-draft.md`

## 4. Submit Issues

1. **TailwindCSS Issue**: 
   - Go to https://github.com/tailwindlabs/tailwindcss/issues/new
   - Copy content from `tailwindcss-issue-draft.md`
   - Submit the issue

2. **Phoenix Framework Issue**:
   - Go to https://github.com/phoenixframework/phoenix/issues/new  
   - Copy content from `phoenix-issue-draft.md`
   - Update with link to the TailwindCSS issue you just created
   - Submit the issue

## Repository URL

Once pushed, your repository will be available at:
https://github.com/YOUR_USERNAME/tailwindcss-v4-arch-bug