#pragma once
#include "Parser.hpp"
#include "JSONStructure.hpp"
#include "JSONValue.hpp"

class PathParser : public Parser
{
public:
	PathParser(const String&, JSONStructure*);
	JSONValue* get_element();
	JSONValue* create_element();
	bool delete_element();
private:
	bool has_next() const;
	JSONValue* get_next_element(size_t);
	JSONValue* create_next_element(size_t);
	bool get_or_delete_next_element(size_t, JSONValue*);
	JSONValue* parse_object();
	JSONValue* parse_array_element();
	JSONValue* parse_object_or_create();
	JSONValue* parse_array_element_or_create();
	JSONStructure* m_str;
	JSONValue* cur_value;
};