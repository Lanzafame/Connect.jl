module ConnectSDK

using HTTPClient.HTTPC
using JSON

export ConnectClient
export push

# package code goes here
type ConnectClient
  projectid
  apikey
  baseurl::String

  function ConnectClient(projectid::String, apikey::String)
	baseurl = "https://api.getconnect.io/events/"
	projectid = ("X-Project-Id", projectid)
	apikey = ("X-Api-Key", apikey)

	new(projectid, apikey, baseurl)
  end

end #ConnectClient

function push(client::ConnectClient, collection::String, data::Dict{Any,Any})
  data = JSON.json(data)
  r = HTTPC.post(client.baseurl * collection, data, RequestOptions(headers=[client.projectid, client.apikey]))
  return r
end

function query(client::ConnectClient, collection::String, query::String)

end


# example push/post url: https://api.getconnect.io/events/purchases where purchases is the collection

# example query url: https://api.getconnect.io/events/purchases?query={select:{totalPrice:{sum:'price'}}}



end # module
