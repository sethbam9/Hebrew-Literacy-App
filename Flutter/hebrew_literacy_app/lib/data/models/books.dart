import 'package:flutter/material.dart';
import 'models.dart';
import '../database/hebrew_bible_data/hb_db_helper.dart';

class Books {
  static late final List<Book> books;

  static Future<void> getBooks() async {
    books = await HebrewDatabaseHelper().getBooks();
  }

  static Book getBookById(int bookId) {
    return books.firstWhere((b) => b.id == bookId);
  }
}