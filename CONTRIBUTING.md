# Submitting a Patch

This accepts patches through GerritHub changes. Each commit pushed to
GerritHub is recognized as a "change" (the equivalent of a GitHub pull
request). When a change is pushed to GerritHub for review, it contains an
initial patch set that shows all of the revised changes. When a Gerrit change
is amended, a new patch set is created to show the differences from the
previous patch set.

The general workflow for submitting a change is:

  1. Select an issue - select an issue from the GitHub issues page by commenting
     on the issue itself.
  2. Submit a GerritHub change for review.
  3. Review - Project maintainers and contributors will review the change on
     GerritHub and may request that additional patch sets be submitted before
     the change can be merged.
  4. Merge or close - the change is either merged or closed by the project
     maintainers.

## Using GerritHub

In order to use GerritHub, you must first authorize GerritHub to access your
GitHub profile and import SSH public keys by signing in at
[gerrithub.io](http://gerrithub.io)

In order to submit a change using GerritHub, the
[git review]*(https://docs.openstack.org/infra/git-review/) tool must be
installed. Git-review can be installed using Python
[pip](https://pypi.python.org/pypi/pip) by executing:

    pip install git-review

Git-review can also be installed on Ubuntu by executing:

    apt-get install git-review

After installing git-review, clone the repository from GerritHub

    git clone https://review.gerrithub.io/mpeterson/kubernetes-federationv2-cluster-demo

Change to the repository root directory and configure git-review to use
GerritHub. This will verify that login is possible using your imported
[SSH public keys](https://help.github.com/articles/connecting-to-github-with-ssh/)

    cd kubernetes-federationv2-cluster-demo
    git review -s

If you require authentication over HTTPS, you will need to generate an
[HTTPS password](https://review.gerrithub.io/#/settings/http-password)
Once you have generated an HTTPS password, add the repository to your remote
repositories

    git remote add gerrit https://<username>@review.gerrithub.io/a/mpeterson/kubernetes-federationv2-cluster-demo

Now that your local repository is configured, create a local branch for your
change using the format `<TYPE>/<DESC>`, where `TYPE` is the type
of change (i.e. feat, bug, docs)  and `DESC` is a hyphenated
description of the change (i.e. new-endpoints).

An example branch name for a feature that adds more API endpoints might be
`feat/new-endpoints`.

    git checkout -b <BRANCH-NAME>

When you are ready to submit your local changes for review, commit your
changes:

    git commit

Below is a list of possible types:

| Type     | Description                                           |
|----------|-------------------------------------------------------|
| feat     | Adds a new feature                                    |
| fix      | Fixes a confirmed bug or other unexpected behavior    |
| docs     | Documentation update                                  |
| style    | Reformats existing code to conform to the style guide |
| refactor | Refactors existing code to improve readability        |
| test     | Adds additional tests                                 |

Since each commit is represented as a "change" in GerritHub, multiple commits
should be squashed into one commit before pushing to GerritHub for review. To
squash redundant commits, execute:

    git rebase -i

Change "pick" to "squash" next to every commit except for the one containing
the commit message you wish to use for your Gerrit change.

To push your change for review, execute:

    git review

Your change will now be visible on GerritHub for review. In order to amend your
change after pushing it for review, you will need to create additional
patch sets.

In order to create an additional patch set, modify your existing commit and
push your new changes for review

    git commit --amend
    git review

An additional patch set will now appear on the original GerritHub change.

## Work in Progress

Uploading changes that are not yet complete is highly encouraged in order to
receive early feedback from project maintainers and other contributors. To
label your change as a work in progress, leave a code review of your own
patch set with a vote of -1 and a comment indicating that your patch set is a
work in progress.

## Rebasing A Commit

If changes have occurred to the master branch since your local branch was last
updated, you will need to rebase your commit with the new changes.

Update master locally

    git checkout master
    git remote update

Return to your branch and rebase with master

    git checkout <BRANCH>
    git rebase origin/master

After resolving all merge conflicts, resume the rebase

    git rebase --continue

## Code Review Workflow

Once a change is submitted to GerritHub, project maintainers and other
contributors will review it and leave feedback. In order for a change to be
merged, a change must have at least two +2 votes from project maintainers, and
must pass all Jenkins continuous integration tests.

## Continuous Integration Testing

All patch sets submitted to the project's GerritHub undergo continuous integration
testing performed by Jenkins. If the Jenkins build is successful, Jenkins will
leave a code review with a vote of +1. If the Jenkins build fails, Jenkins will
leave a code review with a vote of -1.

In order to ensure that your patch set passes the continuous integration tests
and conforms to the PEP8 style guide, execute:

    tox -e pep8
    tox -e py35
    tox -e coverage

# Contributor Covenant Code of Conduct

## Our Pledge

In the interest of fostering an open and welcoming environment, we as
contributors and maintainers pledge to making participation in our project and
our community a harassment-free experience for everyone, regardless of age, body
size, disability, ethnicity, sex characteristics, gender identity and expression,
level of experience, education, socio-economic status, nationality, personal
appearance, race, religion, or sexual identity and orientation.

## Our Standards

Examples of behavior that contributes to creating a positive environment
include:

* Using welcoming and inclusive language
* Being respectful of differing viewpoints and experiences
* Gracefully accepting constructive criticism
* Focusing on what is best for the community
* Showing empathy towards other community members

Examples of unacceptable behavior by participants include:

* The use of sexualized language or imagery and unwelcome sexual attention or
  advances
* Trolling, insulting/derogatory comments, and personal or political attacks
* Public or private harassment
* Publishing others' private information, such as a physical or electronic
  address, without explicit permission
* Other conduct which could reasonably be considered inappropriate in a
  professional setting

## Our Responsibilities

Project maintainers are responsible for clarifying the standards of acceptable
behavior and are expected to take appropriate and fair corrective action in
response to any instances of unacceptable behavior.

Project maintainers have the right and responsibility to remove, edit, or
reject comments, commits, code, wiki edits, issues, and other contributions
that are not aligned to this Code of Conduct, or to ban temporarily or
permanently any contributor for other behaviors that they deem inappropriate,
threatening, offensive, or harmful.

## Scope

This Code of Conduct applies both within project spaces and in public spaces
when an individual is representing the project or its community. Examples of
representing a project or community include using an official project e-mail
address, posting via an official social media account, or acting as an appointed
representative at an online or offline event. Representation of a project may be
further defined and clarified by project maintainers.

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported by contacting the project team at [INSERT EMAIL ADDRESS]. All
complaints will be reviewed and investigated and will result in a response that
is deemed necessary and appropriate to the circumstances. The project team is
obligated to maintain confidentiality with regard to the reporter of an incident.
Further details of specific enforcement policies may be posted separately.

Project maintainers who do not follow or enforce the Code of Conduct in good
faith may face temporary or permanent repercussions as determined by other
members of the project's leadership.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage], version 1.4,
available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html

[homepage]: https://www.contributor-covenant.org

For answers to common questions about this code of conduct, see
https://www.contributor-covenant.org/faq

