#pragma once

#include <string>
#include <variant>
#include <vector>
#include <memory>

using String = std::string;

template <typename T>
using Pointer = std::unique_ptr<T>;

template <typename T>
using Vector = std::vector<T>;

template <typename T, typename U>
using Pair = std::pair<T, U>;

enum class Type
{
	b,
	s,
	n,
	obj,
	ar,
	nul
};

class JSONValue
{
public:
	JSONValue(Type, bool, const String&, double, const Vector<Pair<String, Pointer<JSONValue>>>&, const Vector<JSONValue>&);
	JSONValue();
	JSONValue(bool);
	JSONValue(const String&);
	JSONValue(double);
	JSONValue(const Vector<Pair<String, Pointer<JSONValue>>>&);
	JSONValue(const Vector<JSONValue>&);
	JSONValue(const JSONValue&);
	JSONValue& operator=(const JSONValue&);
	bool operator==(const JSONValue&) const;
	~JSONValue() = default;
	std::variant<
		bool,
		String,
		double,
		Vector<Pair<String, Pointer<JSONValue>>>,
		Vector<JSONValue>> get_value();
	Pointer<JSONValue> clone() const;
	void print_tabs(std::ostream&, size_t) const;
	void print(std::ostream&, size_t) const;
	Vector<JSONValue> search(const String&);
	JSONValue* get_object_by_key(const String&);
	JSONValue* get_array_element(int);
	void set_value(const String&);
	JSONValue* add_new_object(const String&);
	JSONValue* add_array_element(int);
	bool set_value_check(const String&);
	bool delete_el(JSONValue);
	void write_to_file(std::ofstream&, size_t);
private:

	Type t{ Type::n };
	bool boolean{};
	String string{};
	double number{};
	Vector<Pair<String, Pointer<JSONValue>>> object{};
	Vector<JSONValue> arr{};
};