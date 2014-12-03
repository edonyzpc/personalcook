#### First, 
for the guy who access the Two-Factor Authentication in Github, you should create an access token for command-line use. 
##### Try about this article:[https://help.github.com/articles/creating-an-access-token-for-command-line-use/](https://help.github.com/articles/creating-an-access-token-for-command-line-use/)

------
#### Second,
create a new repository within your account which already got a Authentication Token.

------
#### Type in the CLI with:
##### $ `curl -u <token>:x-oauth-basic https://api.github.com/user/repos -d '{"name":"projectname", "description":"..."}'`
##### $ `vim README.md (Edit the description about for this project)`
##### $ `git init`
##### $ `git add README.md`
##### $ `git commit -m "..."`
##### $ `git remote add origin git@github.com:'USERNAME'/'projectname'.git`
##### $ `git push -u origin master`
------
REFERENCE:
[http://stackoverflow.com/questions/2423777/is-it-possible-to-create-a-remote-repo-on-github-from-the-cli-without-ssh](http://stackoverflow.com/questions/2423777/is-it-possible-to-create-a-remote-repo-on-github-from-the-cli-without-ssh)
