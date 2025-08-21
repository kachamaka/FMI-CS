#include "XMLCommand.hpp"
#include "XPathParser.hpp"
#include <iostream>
#include <fstream>
#include <algorithm>

XMLCommand::XMLCommand(XMLTree* tree) : m_tree{ tree }
{
}

