
import 'dart:convert';
import 'package:http/http.dart'as http;

class Api{

  static Future<List?>fatchNode()async{
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200 ){
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    }else{
      return null;
    }
  }


static Future<bool>addNote( Map body) async{
  const url ='https://api.nstack.in/v1/todos';
  final uri = Uri.parse(url);
  final response = await http.post(uri,
  body: jsonEncode(body),
  headers: {'Content-type':'application/json'},
  );
return response.statusCode== 201 ;
}

static Future<bool>updateNote(String id,Map body) async{
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.put(uri, 
  body:jsonEncode(body),
  headers:{'Content-type':'application/json'},
  );
  return response.statusCode==200;
}

static Future<bool>deleteById(String id) async{
  final url = 'https://api.nstack.in/v1/todos/$id';
  final uri = Uri.parse(url);
  final response = await http.delete(uri);
  return response.statusCode==200;
}
static Future<bool>patchUpdate(String id,Map body)async{
  final url='http://localhost:8080/api/$id';
  final uri=Uri.parse(url);
  final response=await http.patch(uri, 
  body:jsonEncode(body),
  headers:{'Content-type':'application/json'},
  );
  return response.statusCode==200;
}
}
