#!/usr/bin/env zx

const idsCs = "";
const ids = idsCs.split(",");

$`echo $MY_GITHUB_TOKEN | gh auth login --with-token`;

// console.log(process.env.MY_GITHUB_TOKEN);

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
  try {
    const res = $([command]);
    console.log(res);
  } catch (e) {
    console.log(`${id} failed`);
  }
}
