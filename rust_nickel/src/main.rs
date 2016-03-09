#[macro_use] extern crate nickel;
extern crate rustc_serialize;

use std::collections::BTreeMap;
use nickel::status::StatusCode;
use nickel::{Nickel, HttpRouter, JsonBody, Request, Response, MiddlewareResult};
use rustc_serialize::json::{Json, ToJson};

#[derive(RustcDecodable, RustcEncodable)]
struct BodyValue {
  name: String
}

#[derive(RustcDecodable, RustcEncodable)]
struct Body {
  value: BodyValue
}

fn make_response(str: String) -> Json {
  let mut resp = BTreeMap::new();
  let mut result = BTreeMap::new();
  result.insert("msg".to_string(), str.to_json());
  resp.insert("result".to_string(), Json::Object(result));
  Json::Object(resp)
}

fn init<'mw>(_req: &mut Request, res: Response<'mw>) -> MiddlewareResult<'mw> {
  res.send("")
}

fn run<'mw>(req: &mut Request, res: Response<'mw>) -> MiddlewareResult<'mw> {
  let body = try_with!(res, {
    req.json_as::<Body>().map_err(|e| (StatusCode::BadRequest, e))
  });
  let response = make_response("Hello, ".to_string() + &body.value.name);
  res.send(response)
}

fn main() {
  let mut server = Nickel::new();
  server.post("/init", init);
  server.post("/run", run);
  server.listen("0.0.0.0:8080");
}
