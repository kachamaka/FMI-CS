#include "XMLParser.hpp"
#include "XMLCommand.hpp"
#include "InvalidCommand.hpp"
#include<cstdio>
#include<cctype>
#include<algorithm>

void XMLParser::read(std::istream& in)
{
	std::stringstream buffer;
	buffer << in.rdbuf();
	content = buffer.str();
}

void XMLParser::parse(XMLTree* tree)
{
	std::optional<XMLElement> element = parse_element(0);
	if (!element)
	{
		InvalidCommand inv_file_cmd{ "Invalid file format." };
		inv_file_cmd.execute();
	}
	else
	{
		tree->set_root(element.value());
		tree->set_ids();
	}
}

std::optional<XMLElement> XMLParser::parse_element(size_t position)
{
	parse_whitespace(updated_position);

	std::optional<char> ch = parse_character('<', updated_position);
	if (!ch) return {};

	parse_whitespace(updated_position);

	std::optional<String> name = parse_string(updated_position, { ' ' , '>' }, { '=', '\"', '<', '/' });
	if (!name) return {};

	

	Vector<Pair> attributes = parse_attributes(updated_position);
	

	ch = parse_character('>', updated_position);
	if (!ch) return {};

	XMLContent content = parse_contents(updated_position, name.value());

	return XMLElement{name.value(), attributes, content.get_elements(), content.get_text()};
}



std::optional<String> XMLParser::parse_value(size_t position)
{
	if (content[updated_position] != '\"')return{};
	update_position(updated_position + 1);

	std::optional<String> value = parse_string(updated_position, { '\"' }, {});

	if (!value) return {};
	update_position(updated_position + 1);
	return value.value();

}

Vector<Pair> XMLParser::parse_attributes(size_t position)
{
	std::optional<Pair> attr = parse_attribute(position);
	if (!attr)
	{
		return {};
	}
	else
	{
		Vector<Pair> rt = parse_attributes(updated_position);
		rt.push_back(attr.value());
		return rt;
	}
}

std::optional<Pair> XMLParser::parse_attribute(size_t position)
{
	parse_whitespace(updated_position);

	std::optional<String> key = parse_string(updated_position, { ' ', '=' }, {'<', '>', '\"'});
	if (!key)return{};

	parse_whitespace(updated_position);

	std::optional<char> ch = parse_character('=', updated_position);
	if (!ch)return{};
	parse_whitespace(updated_position);

	

	std::optional<String> value = parse_value(updated_position);
	if (!value)return{};

	Pair rt = { key.value(), value.value() };
	return rt;
}

template<class... Ts> struct overloaded : Ts... { using Ts::operator()...; };
template<class... Ts> overloaded(Ts...)->overloaded<Ts...>;
XMLContent XMLParser::parse_contents(size_t position, const String name)
{

	auto el = parse_content(position, name);

	if (!el) return {};
	XMLContent content = parse_contents(updated_position, name);

	std::visit(overloaded{
		[&content](const String& arg)-> void {
		content.concat_text(arg);
	},
		[&content](XMLElement arg)-> void {
		content.add_element(arg);
	}
		}, el.value());

	return content;
}

std::optional<std::variant<String, XMLElement>> XMLParser::parse_content(size_t position, const String& name)
{
	parse_whitespace(updated_position);

	if (parse_closing_tag(updated_position, name))
	{
		return {};
	}

	if (is_tag(updated_position))
	{
		std::optional<XMLElement> element = parse_element(updated_position);
		if (!element) return {};
		return element.value();
	}
	else
	{
		std::optional <String> text = parse_string(updated_position, {'<'}, {'>', '/', '='});
		
		if (!text)return {};
		return text.value();
	}
}

std::optional<String> XMLParser::parse_closing_tag(size_t position, const String& name)
{
	if (content[updated_position] != '<' || content[updated_position+1] != '/')return {};
	update_position(updated_position + 2);

	parse_whitespace(updated_position);

	std::optional<String> tag_name = parse_string(updated_position, {' ', '>'}, {'\"', '=', '/'});
	if (!tag_name || tag_name!=name)return{};

	parse_whitespace(updated_position);

	std::optional<char> ch = parse_character('>', updated_position);
	if (!ch) return {};

	return name;
}

bool XMLParser::is_tag(size_t position)
{
	return content[position] == '<';
}