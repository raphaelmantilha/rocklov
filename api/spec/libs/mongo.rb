require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def insert_users(docs)
    @users.insert_many(docs)
  end

  def drop_danger
    client.database.drop
  end

  def remove_user(email)
    @users.delete_many({ "email": email })
  end

  def get_user(email)
    user = users.find({ email: email }).first
    return user[:_id]
  end

  def remove_equipamento(name, user_id)
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipos.delete_many({ name: name, user: obj_id })
  end

  def get_mongo_id
    return BSON::ObjectId.new
    #retorna um ObjectId aleatório no formato do MongoDB
  end
end

#MongoDB.new.get_user("raphael.mantilha_login@gmail.com")
