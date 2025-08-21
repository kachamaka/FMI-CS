#pragma once
#include <string>
#include "XMLElement.hpp"

#pragma once

using String = std::string;

class XMLTree
{
public:
	XMLTree() = default;
	XMLTree(const String&);

	void erase();
	void parse(std::istream&);
	void save();
	void save_as(const String&);

	bool empty() const;

	void set_root(const XMLElement&);

	void set_ids();

	XMLElement& get_element_by_id(const String&);

	friend std::ostream& operator<<(std::ostream&, const XMLTree&); 

	void set_open_file_name(const String&);
	String get_open_file_name() const;

private:

	String open_file_name{ "" };
	XMLElement m_root{};
};