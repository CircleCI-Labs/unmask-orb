# Unmask orb

[![CircleCI Build Status](https://circleci.com/gh/circleci-labs/unmask-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/circleci-labs/unmask-orb) [![CircleCI Orb Version](https://badges.circleci.com/orbs/cci-labs/unmask.svg)](https://circleci.com/developer/orbs/orb/cci-labs/unmask) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/circleci-labs/unmask-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

CircleCI masks the contents of user-defined environment variables when printed as output. This conveniently helps reduce the impact of accidentally printing secrets. However, in some instances, it may be desirable to print the raw contents of a variable.

This orb provides a basic utility to accomplish this.

In order for it to work, you must prefix the value of your environment variable with a configurable prefix (by default it is `UNMASKABLE:`).

For example, if your env var contains `FOO`, you'd need to update it to `UNMASKABLE:FOO`. This orb can then be used to strip the prefix and re-set the variable at run time, after which it can be viewed when printed. See [example](#example) for more.

**Disclaimer:**

CircleCI Labs, including this repo, is a collection of solutions developed by members of CircleCI's field engineering teams through our engagement with various customer needs.

-   ✅ Created by engineers @ CircleCI
-   ✅ Used by real CircleCI customers
-   ❌ **not** officially supported by CircleCI support


## Example

```yaml
version: 2.1

orbs:
  unmask: cci-labs/unmask@0.1.0

jobs:
  # If a project env var called MY_VAR is configured as "UNMASKABLE:FOO"
  print-var:
    docker:
      - image: cimg/base:edge
    steps:
      - run: echo $MY_VAR # will try and print UNMASKABLE:FOO and show as *************
      - unmask/setup:
          variable: $MY_VAR
          # Optionally set the prefix you want to use instead of UNMASKABLE: with e.g
          # prefix: "ABCDE:"
      - run: echo $MY_VAR # will print FOO

workflows:
  # ... etc
```

## Resources

- [CircleCI Orb Registry Page](https://circleci.com/developer/orbs/orb/cci-labs/unmask) - The official registry page of this orb for all versions, executors, commands, and jobs described.
- [CircleCI Orb Docs](https://circleci.com/docs/orb-intro/#section=configuration) - Docs for using, creating, and publishing CircleCI Orbs.
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [Reusable Configuration](https://circleci.com/docs/2.0/reusing-config)
 - [Secret Masking](https://circleci.com/docs/env-vars/#secrets-masking)

### How to Contribute

We welcome [issues](https://github.com/circleci-labs/unmask-orb/issues) to and [pull requests](https://github.com/circleci-labs/unmask-orb/pulls) against this repository!

### How to Publish An Update
1. Merge pull requests with desired changes to the main branch.
    - For the best experience, squash-and-merge and use [Conventional Commit Messages](https://conventionalcommits.org/).
2. Find the current version of the orb.
    - You can run `circleci orb info cci-labs/unmask | grep "Latest"` to see the current version.
3. Create a [new Release](https://github.com/circleci-labs/unmask-orb/releases/new) on GitHub.
    - Click "Choose a tag" and _create_ a new [semantically versioned](http://semver.org/) tag. (ex: v1.0.0)
      - We will have an opportunity to change this before we publish if needed after the next step.
4.  Click _"+ Auto-generate release notes"_.
    - This will create a summary of all of the merged pull requests since the previous release.
    - If you have used _[Conventional Commit Messages](https://conventionalcommits.org/)_ it will be easy to determine what types of changes were made, allowing you to ensure the correct version tag is being published.
5. Now ensure the version tag selected is semantically accurate based on the changes included.
6. Click _"Publish Release"_.
    - This will push a new tag and trigger your publishing pipeline on CircleCI.