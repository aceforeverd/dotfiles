set -l user_paths $fish_user_paths

set -l TEMP_DIR /tmp/(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
set -l NON_EXIST_PATH /tmp/(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
mkdir -p $TEMP_DIR
set_color green; echo creating directory $TEMP_DIR; set_color normal

@test "fish_user_paths: not contains me" (contains -- $TEMP_DIR $fish_user_paths) $status -ne 0

@test "fish_user_paths_add: it tell me added" (fish_user_paths_add $TEMP_DIR > test.log) $status -eq 0
cat test.log

@test "fish_user_paths_add: really added" (contains -- $TEMP_DIR $fish_user_paths) $status -eq 0

@test "fish_user_paths_add: avoid add multiple times" (fish_user_paths_add $TEMP_DIR > test.log) $status -eq 2
cat test.log

@test "fish_user_paths_add: still have me" (contains -- $TEMP_DIR $fish_user_paths) $status -eq 0

@test "path not exist" ! -d $NON_EXIST_PATH
@test "fish_user_paths_add: add non-exist path" (fish_user_paths_add $NON_EXIST_PATH > test.log) $status -eq 1
cat test.log
@test "fish_user_paths_add: really not added" (contains -- $NON_EXIST_PATH $fish_user_paths) $status -ne 0

@test "fish_user_paths_rm: removing not exist path" (fish_user_paths_rm $NON_EXIST_PATH > /dev/null) $status -eq 1
@test "fish_user_paths_rm: removed" (fish_user_paths_rm $TEMP_DIR > test.log) $status -eq 0
cat test.log

rm -r $TEMP_DIR
rm test.log
set_color green; echo removed $TEMP_DIR; set_color normal