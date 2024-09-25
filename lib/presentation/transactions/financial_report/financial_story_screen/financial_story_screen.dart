import 'dart:async';

import 'package:expenseecho/core/utils/theme_colors.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_budget/financial_story_budget_screen.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_expense/financial_story_expense_screen.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_income/financial_story_income_screen.dart';
import 'package:expenseecho/presentation/transactions/financial_report/financial_story_quote/financial_story_quote_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FinancialStoryScreen extends StatefulWidget {
  const FinancialStoryScreen({super.key});

  @override
  _FinancialStoryScreenState createState() => _FinancialStoryScreenState();
}

class _FinancialStoryScreenState extends State<FinancialStoryScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  final int _numPages = 4;
  final Duration _storyDuration = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: redThemeColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  void _startTimer() {
    _timer = Timer.periodic(_storyDuration, (Timer timer) {
      if (_currentPage < _numPages - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _timer.cancel();
      }
    });
  }

  void _setStatusBarColor(int index) {
    Color statusBarColor;
    switch (index) {
      case 0:
        statusBarColor = redThemeColor;
        break;
      case 1:
        statusBarColor = greenThemeColor;
        break;
      case 2:
        statusBarColor = violetColor;
        break;
      case 3:
        statusBarColor = violetColor;
        break;
      default:
        statusBarColor = violetColor;
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    if (dx < screenWidth / 3) {
      // Tap on the left side
      if (_currentPage > 0) {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } else if (dx > 2 * screenWidth / 3) {
      // Tap on the right side
      if (_currentPage < _numPages - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: _onTapDown,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _numPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                  _setStatusBarColor(index);
                });
              },
              itemBuilder: (context, index) {
                return _buildStoryPage(index);
              },
            ),
            Positioned(
              top: 60,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(_numPages, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: LinearProgressIndicator(
                        value: _currentPage == index ? 1.0 : 0.0,
                        backgroundColor: lightThemeColor[20],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            lightThemeColor),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildStoryPage(int index) {
    if (index == 0) {
      return const FinancialStoryExpenseScreen();
    } else if (index == 1) {
      return const FinancialStoryIncomeScreen();
    } else if (index == 2) {
      return const FinancialStoryBudgetScreen();
    } else {
      return const FinancialStoryQuoteScreen();
    }
  }
}
