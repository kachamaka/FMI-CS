#pragma once
#include "Parser.hpp"
#include "JSONStructure.hpp"
#include <memory>

template<typename T>
using Pointer = std::unique_ptr<T>;

class JSONParser : public Parser
{
public:
	JSONParser(const String&);
	Optional<JSONValue> parse();
private:
	Optional<JSONValue> parse_value(size_t);
	Optional<String> parse_json_string();
	Optional<double> parse_number();
	Optional<bool> parse_boolean();
	Optional<Vector<JSONValue>> parse_array(size_t);
	Optional<Pair<String, Pointer<JSONValue>>> parse_member();
	Optional<Vector<Pair<String, Pointer<JSONValue>>>> parse_object();
};