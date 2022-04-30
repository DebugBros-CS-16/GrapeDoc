import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grapedoc_test/screens/AddBlog.dart';

void main () {
  test("Title cannot be null", (){
    TextEditingController titleTest1 =TextEditingController();
    var test1;
    titleTest1.text = "";

    if(titleTest1.text == ""){
      test1 = 'Title Can\'t Be Empty';
    }
    else{
      test1 = 'Title is valid';
    }

    final blogTest = validBlog();
    blogTest.blogPostTitle(titleTest1);
    expect(blogTest.blogPostTitle(titleTest1),test1);
  });

  test("Description cannot be null", (){
    TextEditingController descriptionTest1 =TextEditingController();
    var test2;
    descriptionTest1.text = "";

    if(descriptionTest1.text == ""){
      test2 = 'Description Can\'t Be Empty';
    }
    else{
      test2 = 'Description is valid';
    }

    final blogTest = validBlog();
    blogTest.blogPostDescription(descriptionTest1);
    expect(blogTest.blogPostDescription(descriptionTest1),test2);
  });
}