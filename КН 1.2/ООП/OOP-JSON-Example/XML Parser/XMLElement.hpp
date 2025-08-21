#pragma once
#include <string>
#include <vector>
#include<optional>
#include<iostream>

using String = std::string;
using Pair = std::pair<String, String>;

template <typename T>
using Vector = std::vector<T>;

#pragma once

class XMLElement
{
public:
	XMLElement() = default;
	XMLElement(const String&, const Vector<Pair>&, const Vector<XMLElement>&, const String&);

	//accessors
	String get_name() const;
	Vector<Pair> get_attributes() const;
	Vector<XMLElement> get_children() const;
	String get_text() const;
	String get_id() const;
	String get_attribute_by_key(const String&) const;
	Vector<XMLElement> get_children_by_name(const String&) const;

	bool has_child_with_text(const String&, const String&) const;

	//!!!pass by reference
	XMLElement& get_child_element_by_id(const String& id);

	//mutators
	void set_name(const String&);
	void add_attribute(const Pair&);
	void set_id(); 
	void set_attribute_by_key(const String&, const String&);
	void add_child();
	void remove_attribute(const String&);

	friend std::ostream& operator<<(std::ostream&, const XMLElement&);
	void print_in_xml(size_t, std::ostream&) const;

	XMLElement* clone() const;

private:
	XMLElement* get_by_id(const String&);
	String get_unique_id(String);
	void print(size_t, std::ostream&) const;
	void print_tabs(size_t, std::ostream&) const;

	String m_name{"empty"};
	Vector<Pair> m_attributes{};
	Vector<XMLElement> m_elements{};
	String m_text{};
	String m_id{};

	static Vector<String> ids;
};
