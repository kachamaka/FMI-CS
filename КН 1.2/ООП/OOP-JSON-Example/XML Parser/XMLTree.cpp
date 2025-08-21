#include "XMLTree.hpp"
#include "XMLParser.hpp"
#include <iostream>
#include <fstream>

XMLTree::XMLTree(const String& file_name) : open_file_name{ file_name }
{
}

void XMLTree::erase()
{
	open_file_name = "";
	m_root = XMLElement{};
}

void XMLTree::parse(std::istream& in)
{
	XMLParser parser{};
	parser.read(in);
	parser.parse(this);
}

void XMLTree::set_open_file_name(const String& file_name)
{
	open_file_name = file_name;
}
String XMLTree::get_open_file_name() const
{
	return open_file_name;
}

XMLElement& XMLTree::get_element_by_id(const String& id)
{
	return m_root.get_child_element_by_id(id);
}

void XMLTree::set_root(const XMLElement& root)
{
	m_root = root;
}

void XMLTree::set_ids()
{
	m_root.set_id();
}

bool XMLTree::empty() const
{
	return open_file_name.empty();
}

void XMLTree::save()
{
	std::ofstream out{ open_file_name };
	m_root.print_in_xml(0, out);
}

void XMLTree::save_as(const String& file_name)
{
	set_open_file_name(file_name);
	save();
}

std::ostream& operator<<(std::ostream& out, const XMLTree& tree)
{
	out << tree.m_root;
	return out;
}