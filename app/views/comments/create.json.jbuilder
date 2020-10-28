# JavaScriptで必要な情報を渡す
# json.KEY VALUEという形で書く

# viewと同じように該当するアクションと同じ名前にする必要がある

# JavaScriptファイルに返ってきたデータを
# jbuilderで定義したキーとバリューの形で呼び出して使うことができる

json.text  @comment.text
json.user_id  @comment.user.id
json.user_name  @comment.user.nickname