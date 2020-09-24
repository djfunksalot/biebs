db_host<-Sys.getenv('DB_HOST')
if( nchar(db_host)==0) db_host='localhost'
db_url<-paste0("mongodb://",db_host)

Db.list = function (collection,user) {
  records <- mongo(collection = collection,url=db_url)
  records$find(paste0('{"user":"',user,'"}'))
}
Db.save = function (collection,user,object,name="") {
  records <- mongo(collection = collection,url=db_url)
fs<-gridfs(
  db = "test",
  url = db_url
#  prefix = "fs",
#  options = ssl_options()
)
  id=tolower(paste0(sample(c(0:9,LETTERS[1:6]),32,T),collapse=''))
  buf<-serialize(object,NULL)
  fs$write(buf,id)
  record<-list(
    id=id,
    name=name,
    user=user,
    created = Sys.time()
  )
  records$insert(record)
}
Db.load = function (id) {
fs<-gridfs(
  db = "test",
  url = db_url
#  prefix = "fs",
#  options = ssl_options()
)
  out <- fs$read(id)
  return(data.table(unserialize(out$data)))
}
