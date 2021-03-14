set -l user_paths $fish_user_paths

set -l TEMP_DIR /tmp/(openssl rand -base64 8)
set -l NON_EXIST_PATH /tmp/(openssl rand -base64 8)
mkdir -p $TEMP_DIR

echo creating directory $TEMP_DIR

@test "fish_user_paths: not contains me" (contains -- $TEMP_DIR $fish_user_paths) $status -ne 0

@test "fish_user_paths_add: it tell me added" (fish_user_paths_add $TEMP_DIR > test.log) $status -eq 0
echo -n -e "\t"
cat test.log

@test "fish_user_paths_add: really added" (contains -- $TEMP_DIR $fish_user_paths) $status -eq 0

@test "fish_user_paths_add: avoid add multiple times" (fish_user_paths_add $TEMP_DIR > test.log) $status -eq 2
echo -n -e "\t"
cat test.log

@test "fish_user_paths_add: still have me" (contains -- $TEMP_DIR $fish_user_paths) $status -eq 0

@test "path not exist" ! -d $NON_EXIST_PATH
@test "fish_user_paths_add: add non-exist path" (fish_user_paths_add $NON_EXIST_PATH > test.log) $status -eq 1
echo -n -e "\t"
cat test.log
@test "fish_user_paths_add: really not added" (contains -- $NON_EXIST_PATH $fish_user_paths) $status -ne 0

@test "fish_user_paths_rm: removing not exist path" (fish_user_paths_rm $NON_EXIST_PATH > /dev/null) $status -eq 1
@test "fish_user_paths_rm: removed" (fish_user_paths_rm $TEMP_DIR > test.log) $status -eq 0
echo -n -e "\t"
cat test.log
@test "fish_user_paths_rm: temp dir removed" (contains -- $TEMP_DIR $fish_user_paths) $status -ne 0

set -l SPACE_PATH '/tmp/Path with space'
mkdir -p $SPACE_PATH
@test "fish_user_paths_add: work with space path" (fish_user_paths_add $SPACE_PATH > test.log) $status -eq 0
echo -n -e "\t"
cat test.log
@test "fish_user_paths_add: space path really added" (contains -- $SPACE_PATH $fish_user_paths) $status -eq 0

@test "fish_user_paths_rm: removing space path" (fish_user_paths_rm $SPACE_PATH > test.log) $status -eq 0
echo -n -e "\t"
cat test.log
@test "fish_user_paths_rm: space path removed" (contains -- $SPACE_PATH $fish_user_paths) $status -ne 0

rm -r $TEMP_DIR
rm test.log
echo removed $TEMP_DIR
