
words_path=./words.txt
words=$(cat $ids_path)
algo=md5
encode=hex
SALT=1234567890

for word in $words; do
	key=$(echo "$SALT$word" | openssl $algo -binary | $encode)
	echo "$word,$key"
done