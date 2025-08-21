
#ifndef _STRUCT_GRADES_H_
#define _STRUCT_GRADES_H_
const int SUBJECTS = 5;
struct Marks
{
    int grade;
    char *subject;
    
    char *getSubjects();
    void cleanSubject();
    void getMark(const char *givensubject);
};
#endif