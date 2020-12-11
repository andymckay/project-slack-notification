## Project to Slack Notification

This is an Action that tracks a project board on GitHub for changes in issues. It then sends notifications of changes to those issues to a Slack channel. It's specifically written for org level project boards, but should work on repo level project boards too.

Tracking issue changes:

![Screen Shot 2020-11-24 at 12 13 52 PM](https://user-images.githubusercontent.com/74699/100146310-9231dc00-2e4e-11eb-811d-39176c4d1568.png)

Tracking comments on issues:

![Screen Shot 2020-11-24 at 12 19 31 PM](https://user-images.githubusercontent.com/74699/100146828-53e8ec80-2e4f-11eb-971c-739c7e5b1f11.png)

**How:**

This Action grabs the state of the project board at a certain point and serialises it into JSON and places it in a GitHub repository. Next time it runs, it grabs the data again, compares the two and sends a message to the channel.

This Action is perfect for running on demand via `workflow_dispatch` or regularly using `schedule`.

**You will need:**
* A GitHub personal access token that can access the project board you are monitoring and write access to a repo to store data
* Slack Integration, one of following:
  * Using Slack App
    * Slack App token so the Action can post to a channel.
    * The Slack App will need to be invited to the channel.
  * Using Incoming Webhooks
    * Slack App with Incoming Webhooks enabled.
    * The Webhook for the channel.

**Note:**

*Incoming Webhooks make it easier to integrate Slack App into the Workspace but comes with limitation. Webhooks allow posting messages but does not allow updating existing messages. Feature used when `TRACK_ISSUES` is enabled and a GitHub issue comment was updated after related Slack message was posted.*

**Inputs:**
* `PAT`: A GitHub personal access token with the required access.
* `SLACK_TOKEN`: A Slack token for a Slack App. It is possible to use SLACK_WEBHOOK instead.
* `CHANNEL`: A channel to post notifications too.
* `SLACK_WEBHOOK`: An Incoming Webhook for Slack. Does not allow updating slack messages.
* `PROJECT_URL`: A URL to the project that you'd like to track.
* `REPO_FOR_DATA`: A repository to store data to. It will be stored in a `.data` directory.
* `TRACK_ISSUES` (optional): `true` if you'd like to be notified about comments on issues
* `LABELS` (optional): a list of labels that you'd like to track.

**Examples YML:**

```yaml
name: Test
on:
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/project-slack-notification@main
        with:
          PAT: ${{ secrets.PAT }}
          SLACK_TOKEN: ${{ secrets.SLACK_TOKEN }}
          PROJECT_URL: "https://github.com/orgs/your-cool-org/projects/1"
          CHANNEL: "#your-cool-project-channel"
          REPO_FOR_DATA: "andymckay/data"
```

```yaml
name: Test
on:
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/project-slack-notification@main
        with:
          PAT: ${{ secrets.PAT }}
          SLACK_WEBHOOK: ${{ secrets.MY_CHANNEL_WEBHOOK }}
          PROJECT_URL: "https://github.com/orgs/your-cool-org/projects/1"
          REPO_FOR_DATA: "andymckay/data"
```

**Contributors:**
* @ritchxu
* @kevin-david
* @lukewar
