
#!/usr/bin/env bash

VAR_A="VAR_A"
export VAR_B="VAR_B"

./sub.sh

echo $VAR_C
echo $VAR_D
# (./sub.sh)
