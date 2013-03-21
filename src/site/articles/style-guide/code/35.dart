test1() {
  bool isDeepFried;
  bool hasPieCrust;
  bool vegan;
  bool containsBacon;

  
  if (isDeepFried ||
      (hasPieCrust && !vegan) ||
      containsBacon) {
    print('Bob likes it.');
  }


  test2() {

    bobLikes() =>
      isDeepFried || (hasPieCrust && !vegan) || containsBacon;
  
  }

  test3() {

    bobLikes()
      => isDeepFried || (hasPieCrust && !vegan) || containsBacon;
  
  }

}

