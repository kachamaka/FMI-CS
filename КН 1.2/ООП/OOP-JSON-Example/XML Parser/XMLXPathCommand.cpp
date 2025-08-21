#include "XMLXPathCommand.hpp"
#include "XPathParser.hpp"
#include "InvalidCommand.hpp"
#include <variant>


XMLXPathCommand::XMLXPathCommand(XMLTree* tree, const String& id, const String& xpath) : XMLCommand{ tree },
m_id{ id },
m_xpath{ xpath }
{
}

template<class... Ts> struct overloaded : Ts... { using Ts::operator()...; };
template<class... Ts> overloaded(Ts...)->overloaded<Ts...>;
void XMLXPathCommand::execute()
{

	if (!m_tree->empty())
	{
		XMLElement el = m_tree->get_element_by_id(m_id);
		XPathParser parser{ el, m_xpath };
		std::variant<Vector<XMLElement>, Vector<String>> rt = parser.parse();

		std::visit(overloaded{
		[&parser](Vector<String> arg)-> void {
			std::for_each(arg.begin(), arg.end(), [](const String& str) {
				std::cout << str << std::endl;
			});
		},
		[&parser](Vector<XMLElement> arg)-> void {
			std::for_each(arg.begin(), arg.end(), [](const XMLElement& el) {
				std::cout << el;
			});
		} }, rt);
	}
	else
	{
		InvalidCommand cmd{ "No file is currently open." };
		cmd.execute();
	}
}