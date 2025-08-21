#include "JSONValue.hpp"
#include <algorithm>
#include <memory>
#include <iostream>
#include "JSONParser.hpp"

JSONValue::JSONValue(Type type, bool b, const String& s, double d, const Vector<Pair<String, Pointer<JSONValue>>>& o, const Vector<JSONValue>& a)
{
	t = type;
	boolean = b;
	string = s;
	number = d;
	std::for_each(o.begin(), o.end(), [this](auto& el) {
		Pair<String, Pointer<JSONValue>> p = std::make_pair(el.first, el.second->clone());
		object.emplace_back(std::move(p));
	});
	std::for_each(a.begin(), a.end(), [this](auto el) {
		arr.emplace_back(el);
	});
}

JSONValue::JSONValue()
{
	t = Type::nul;
}

JSONValue::JSONValue(bool val) : boolean{val}
{
	t = Type::b;
}
JSONValue::JSONValue(const String& val) : string{val}
{
	t = Type::s;
}
JSONValue::JSONValue(double val) : number{val}
{
	t = Type::n;
}
JSONValue::JSONValue(const Vector<Pair<String, Pointer<JSONValue>>>& val) 
{
	std::for_each(val.begin(), val.end(), [this](auto& el) {
		Pair<String, Pointer<JSONValue>> p = std::make_pair( el.first, el.second->clone() );
		object.emplace_back(std::move(p));
	});
	t = Type::obj;
}
JSONValue::JSONValue(const Vector<JSONValue>& val)
{
	std::for_each(val.begin(), val.end(), [this](auto el) {
		arr.emplace_back(el);
	});
	t = Type::ar;
}
JSONValue::JSONValue(const JSONValue& other)
{
	t = other.t;
	if (t == Type::b)
	{
		boolean = other.boolean;
	}
	if (t == Type::s)
	{
		string = other.string;
	}
	if (t == Type::n)
	{
		number = other.number;
	}
	if (t == Type::obj)
	{
		std::for_each(other.object.begin(), other.object.end(), [this](auto& el) {
			Pair<String, Pointer<JSONValue>> p = std::make_pair(el.first, el.second->clone());
			object.emplace_back(std::move(p));
		});
	}
	if (t == Type::ar)
	{
		arr = other.arr;
	}
}

JSONValue* JSONValue::get_object_by_key(const String& key) 
{
	if (t != Type::obj) return nullptr;
	for (auto& el : object)
	{
		if (el.first.compare(key) == 0)
		{
			return el.second.get();
		}
	}
	return nullptr;
}

JSONValue* JSONValue::get_array_element(int n)
{
	if (t != Type::ar) return nullptr;
	if (n >= arr.size())throw std::runtime_error("Index out of bounds.");
	return &arr[n];
}

JSONValue& JSONValue::operator=(const JSONValue& other)
{
	JSONValue tmp{ other };
	std::swap(tmp.t, t);
	std::swap(tmp.boolean, boolean);
	std::swap(tmp.string, string);
	std::swap(tmp.number, number);
	std::swap(tmp.object, object);
	std::swap(tmp.arr, arr);
	return *this;
}
std::variant<
	bool,
	String,
	double,
	Vector<Pair<String, Pointer<JSONValue>>>,
	Vector<JSONValue>> JSONValue::get_value() 
{
	if (t == Type::b)
	{
		return boolean;
	}
	if (t == Type::s)
	{
		return string;
	}
	if (t == Type::n)
	{
		return number;
	}
	if (t == Type::obj)
	{
		return std::move(object);
	}
	if (t == Type::ar)
	{
		return arr;
	}
	return {};
}

Pointer<JSONValue> JSONValue::clone() const
{
	return std::make_unique<JSONValue>(t, boolean, string, number, object, arr);
}

void JSONValue::print_tabs(std::ostream& out, size_t depth) const
{
	for (auto i = 0; i < depth; i++)
	{
		out << " ";
	}
}

void JSONValue::print(std::ostream& out, size_t depth) const
{
	if (t == Type::nul)
	{
		out << "null" <<std::endl;

	}
	if (t == Type::b)
	{
		out << std::boolalpha << boolean;
		out << std::endl;
	}
	if (t == Type::s)
	{
		out << string;
		out << std::endl;
	}
	if (t == Type::n)
	{
		out << number;
		out << std::endl;
	}
	if (t == Type::obj)
	{
		out << "Object: " << std::endl;
		std::for_each(object.begin(), object.end(), [&out, &depth, this](auto& el) {
			print_tabs(out, depth);
			out << el.first << ":";
			if (el.second->t == Type::obj || el.second->t == Type::ar)
			{
				out << std::endl;
				print_tabs(out, depth + 1);
			}
			el.second->print(out, depth + 1);
		});
	}
	if (t == Type::ar)
	{
		out << "Array: " << std::endl;
		std::for_each(arr.begin(), arr.end(), [&out, &depth, this](auto& el) {
			print_tabs(out, depth + 1);

			el.print(out, depth+1);
		});
	}
}

Vector<JSONValue> JSONValue::search(const String& key)
{
	Vector<JSONValue> rt;
	if (t == Type::ar)
	{
		std::for_each(arr.begin(), arr.end(), [&key, &rt, this](auto& el) {
			auto add = el.search(key);
			if (t == Type::ar || t == Type::obj)
			{
				rt.insert(
					rt.end(),
					std::make_move_iterator(add.begin()),
					std::make_move_iterator(add.end())
				);
			}
		});
	}
	if (t == Type::obj)
	{
		std::for_each(object.begin(), object.end(), [&key, &rt, this](auto& el) {
			auto k = el.first;
			auto add = el.second->search(key);
			if (t == Type::ar || t == Type::obj)
			{
				rt.insert(
					rt.end(),
					std::make_move_iterator(add.begin()),
					std::make_move_iterator(add.end())
				);
			}
			if (k.compare(key) == 0)
			{
				rt.emplace_back(*el.second);
			}
		});
	}
	return rt;
}

void JSONValue::set_value(const String& str)
{
	JSONParser p{str};
	auto val = p.parse();
	if (!val)
	{
		throw std::runtime_error("Error while parsing element occured");
	}
	auto tmp = val.value();
	std::swap(tmp.t, t);
	std::swap(tmp.boolean, boolean);
	std::swap(tmp.string, string);
	std::swap(tmp.object, object);
	std::swap(tmp.arr, arr);
}

bool JSONValue::set_value_check(const String& str)
{
	JSONParser p{ str };
	auto val = p.parse();
	if (!val)
	{
		throw std::runtime_error("Error while parsing element occured");
	}
	auto tmp = val.value();
	if (*this == val.value()) return false;
	std::swap(tmp.t, t);
	std::swap(tmp.boolean, boolean);
	std::swap(tmp.string, string);
	std::swap(tmp.object, object);
	std::swap(tmp.arr, arr);
	return true;
}

JSONValue* JSONValue::add_new_object(const String& key)
{
	auto obj = std::make_pair(key, std::make_unique<JSONValue>());
	object.emplace_back(std::move(obj));
	return object.back().second.get();
}

JSONValue* JSONValue::add_array_element(int n)
{
	if (n < arr.size())return &arr[n];
	for (auto i{ arr.size() }; i < n; i++)
	{
		arr.emplace_back(JSONValue());
	}
	return &arr.back();
}

bool JSONValue::operator==(const JSONValue& other) const
{
	if (t != other.t) return false;
	if (t == Type::b)
	{
		return boolean == other.boolean;
	}
	if (t == Type::s)
	{
		return string == other.string;
	}
	if (t == Type::n)
	{
		return number == other.number;
	}
	if (t == Type::obj)
	{
		if (object.size() != other.object.size())return false;
		for (auto i = 0; i < object.size(); i++)
		{
			if (!(other.object[i].first.compare(object[i].first) == 0)
				&& !(*other.object[i].second == *object[i].second))return false;
		}
		return true;
	}
	if (t == Type::ar)
	{
		if (arr.size() != other.arr.size())return false;
		for (auto i = 0; i < arr.size(); i++)
		{
			if (!(other.arr[i] == arr[i]))return false;
		}
		return true;
	}
	throw std::runtime_error("Comparison error");
}

bool JSONValue::delete_el(JSONValue val)
{
	if (t == Type::obj)
	{
		auto end = object.end();
		auto itr = std::find_if(object.begin(), object.end(), [&val](auto& el) {
			return (val == *el.second);
		});
		if (itr == object.end())return false;
		object.erase(itr);
		return true;
	}
	else if (t == Type::ar)
	{
		auto itr = std::find(arr.begin(), arr.end(), val);
		if (itr == arr.end())return false;
		arr.erase(itr);
		return true;
	}
	throw std::runtime_error("Nothing found on this path");
}

void JSONValue::write_to_file(std::ofstream& out, size_t depth)
{
	if (t == Type::nul)
	{
		out << "null" << std::endl;

	}
	if (t == Type::b)
	{
		out << std::boolalpha << boolean;
		out << std::endl;
	}
	if (t == Type::s)
	{
		out << '"' << string << '"';
		out << std::endl;
	}
	if (t == Type::n)
	{
		out << number;
		out << std::endl;
	}
	if (t == Type::obj)
	{
		out << "{" << std::endl;
		for (auto i{ 0 }; i<object.size(); i++)
		{
			auto& el = object[i];
			print_tabs(out, depth);
			out << '"'<<el.first << "\":";
			if (el.second->t == Type::obj || el.second->t == Type::ar)
			{
				out << std::endl;
				print_tabs(out, depth + 1);
			}
			el.second->write_to_file(out, depth + 1);
			if (i != object.size() - 1) out << ",";
		};
		out << "}" << std::endl;
	}
	if (t == Type::ar)
	{
		out << "[ " << std::endl;
		for (auto i{ 0 }; i<arr.size(); i++)
		{
			auto& el = arr[i];
			print_tabs(out, depth + 1);
			el.write_to_file(out, depth + 1);
			if (i != arr.size() - 1) out << ",";
		};
		out << "]" << std::endl;
	}
}