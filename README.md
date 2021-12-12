# The Right Way to test your code

Lecture#1
10 mistakes preventing iOS Dev from writing good tests
1. Not writing automated test at all.
2. Not writing because your boss does not want you to test 
    1. Don’t let your boss slow you down
    2. Be the specialist, make your own decisions
3. Using code coverage as the only measure of test suite quality
    1. does not cover all behaviour.
    2. It does not mean it’s fully tested.
4. Writing the test after
5. Writing slow tests
    1.  it should be run less than a second
    2. run 100 times a day
    3. If it takes minute there’s some mistake
6. Writing Flaky Tests
    1. They don’t give you confidence
    2. They sometime fails, sometime success
    3. For eg test which requires on real network, depending on state in which we don’t have control.
7. Using UI tests as the main strategy
    1. they are both slow & flaky.
    2. Run only when needed.
8. Testing only a few things
    1. Apple does not only test model, good teams test all necessary components to gain confidence.
    2. Might loss customer trust [Banking App]
    3. Why more n more manual test.
    4. Great product leads to the another great product
9. Testing more than one thing in a single test method
    1. Just like in UI test.
    2. To avoid launch time, what if test fails, difficult to find the culprit.
    3. Ideally test one behaviour at a time.
    4. Combination of test will give you confidence to move forward quickly.
    5. Test should be simple, other wise you will need to test the test.
    6. Write isolated tests, they does not depend on outside the test file.
10. Coupling tests with implementation details
    1. Tiny change might break the n tests.
    2. It will slow you down.
    3. Focus on testing the behaviour. Does not test the structure, for eg replacing arrays from set, might refactor.

You can only go fast if you go well
Learn outside work & improve in the work, don’t learn bad practice.
Deliver will stuck if they don’t know how to deliver good product timely.

Lecture#2 
The path is much easier and clearer when you know the step-by-step
 3 steps to test
	1.Arrange (Given)
		sut = system under test, which thing to test in test method 	
	2. Act (When)
	3. Assert (Then)
 Lecture #3
    1. spy can be stub but stub cannot be spy
        1. as spy captures events & can contain predefined properties.
