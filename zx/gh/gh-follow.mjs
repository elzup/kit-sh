#!/usr/bin/env zx

const ids = "".split(",");

for (const id of ids) {
  await $`sleep 0.5`;
  const command = `gh api graphql -F userId='${id}' -f query='
mutation followUser($userId: ID!) {
	followUser(input:{ userId: $userId}) {
		clientMutationId
		user { login, id }
	}
}'
`;
  $([command]);
}
