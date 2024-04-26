#!/bin/sh

# This example uses envsubst to support variable substitution in the string parameter type.
# https://circleci.com/docs/orbs-best-practices/#accepting-parameters-as-strings-or-environment-variables
VAR_NAME=$(circleci env subst "${PARAM_VARIABLE}")
VAR_PREFIX=$(circleci env subst "${PARAM_PREFIX}")

echo "Unmasking \$${VAR_NAME}"
echo "Removing prefix ${PARAM_PREFIX} from \$${VAR_NAME}..."

MASKED_VALUE=${!VAR_NAME}
# Remove the prefix from the env var
UNMASKED_VALUE="${MASKED_VALUE#"$VAR_PREFIX"}"

# Now reset the env var in bash env to this new value for subsequent steps to use
echo "export $VAR_NAME=$UNMASKED_VALUE" >> "$BASH_ENV"