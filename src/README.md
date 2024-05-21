# Unmask Orb

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
  unmask: circleci-labs/unmask@0.1.0

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

## See:
 - [Orb Author Intro](https://circleci.com/docs/2.0/orb-author-intro/#section=configuration)
 - [Reusable Configuration](https://circleci.com/docs/2.0/reusing-config)
 - [Secret Masking](https://circleci.com/docs/env-vars/#secrets-masking)