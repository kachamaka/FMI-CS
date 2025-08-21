#pragma once
#include "JSONValue.hpp"
#include <fstream>
#include <memory>

template <typename T>
using Pointer = std::unique_ptr<T>;

class JSONStructure
{
public:
	JSONStructure() = default;
	JSONStructure(const JSONValue&);
	JSONStructure(const JSONValue&, bool);

	Pointer<JSONStructure> clone() const;

	void make_active();
	void make_unactive();

	void set_content(const String&);
	String get_content() const;

	void set_file_name(const String&);
	String get_file_name() const;

	bool is_active() const;

	void parse(const String&);

	void clear();

	friend std::ostream& operator<<(std::ostream&, const JSONStructure&);

	Vector<JSONValue> search(const String&);

	JSONValue* get_element();
private:
	String m_file_name{};
	String raw_content{};
	JSONValue m_base{};
	bool m_is_active{false};
};