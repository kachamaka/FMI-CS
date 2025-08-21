#pragma once
#include "XMLTree.hpp"
#include <fstream>


using FileStream = std::fstream;

class Core
{
public:
	void start();

private:
	XMLTree m_tree{};
};