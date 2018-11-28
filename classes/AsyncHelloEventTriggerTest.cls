@isTest
private class AsyncHelloEventTriggerTest {

    @isTest
    private static void publishDefaultHello() {

        // Given
        Datetime testStartTime = Datetime.now();

        // When
        Test.startTest();

        Cloud_News__e hello = new Cloud_News__e();

        EventBus.publish(hello);

        // Then
        Test.stopTest();

       
    }
}