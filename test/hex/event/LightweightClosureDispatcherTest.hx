package hex.event;

import hex.error.UnsupportedOperationException;
import hex.unittest.assertion.Assert;

/**
 * ...
 * @author Francis Bourre
 */
class LightweightClosureDispatcherTest
{
    private var _dispatcher   : LightweightClosureDispatcher<BasicEvent>;
    private var _listener     : MockEventListener;

    @setUp
    public function setUp() : Void
    {
        this._dispatcher    = new LightweightClosureDispatcher();
        this._listener      = new MockEventListener();
    }

    @tearDown
    public function tearDown() : Void
    {
        this._dispatcher    = null;
        this._listener      = null;
    }

    @test( "Test 'addListener' behavior" )
    public function testAddListener() : Void
    {
        Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.addListener, [ this._listener ], "addListener should throw UnsupportedOperationException" );
    }
	
	@test( "Test 'removeListener' behavior" )
    public function testRemoveListener() : Void
    {
        Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.removeListener, [ this._listener ], "removeListener should throw UnsupportedOperationException" );
    }
	
	@test( "Test 'addEventListener' behavior" )
    public function testAddEventListener() : Void
    {
        Assert.assertTrue( this._dispatcher.addEventListener( "onEvent", this._listener.onEvent ), "'addEventListener' call should return true" );
        Assert.failTrue( this._dispatcher.addEventListener( "onEvent", this._listener.onEvent ), "Same 'addEventListener' calls should return false second time" );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.assertEquals( this._listener.eventReceivedCount, 1, "Event should be received once" );
        Assert.assertEquals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.assertEquals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.assertEquals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }
	
	@test( "Test 'removeEventListener' behavior" )
    public function testRemoveEventListener() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.assertTrue( this._dispatcher.removeEventListener( "onEvent", this._listener.onEvent ), "'removeEventListener' call should return true" );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.assertEquals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.assertIsNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
        Assert.failTrue( this._dispatcher.removeEventListener( "onEvent", this._listener.onEvent ), "Same 'removeEventListener' call should return false second time" );
    }
	
	@test( "Test 'isEmpty' behavior with 'addEventListener'" )
    public function testIsEmptyWithAddEventListener() : Void
    {
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
        this._dispatcher.addEventListener( "eventType", this._listener.onEvent );
        Assert.failTrue( this._dispatcher.isEmpty(), "'isEmpty' should return false" );
        this._dispatcher.removeEventListener( "eventType", this._listener.onEvent );
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );
    }
	
	@test( "Test 'dispatchEvent' behavior" )
    public function testDispatchEvent() : Void
    {
		this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );

        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( event );

        Assert.assertEquals( 1, this._listener.eventReceivedCount, "Event should be received once" );
        Assert.assertEquals( this._listener.lastEventReceived, event, "Event received should be the same that was dispatched" );

        var anotherEvent : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );
        this._dispatcher.dispatchEvent( anotherEvent );

        Assert.assertEquals( this._listener.eventReceivedCount, 2, "Event should be received twice" );
        Assert.assertEquals( this._listener.lastEventReceived, anotherEvent, "Event received should be the same that was dispatched" );
    }
	
	@test( "Test 'removeAllListeners' behavior" )
    public function testRemoveAllListeners() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        var event : BasicEvent = new BasicEvent( "onEvent", this._dispatcher );

        this._dispatcher.removeAllListeners();
        Assert.assertTrue( this._dispatcher.isEmpty(), "'isEmpty' should return true" );

        this._dispatcher.dispatchEvent( event );
        Assert.assertEquals( this._listener.eventReceivedCount, 0, "Event should be received once" );
        Assert.assertIsNull( this._listener.lastEventReceived, "Event received should be the same that was dispatched" );
    }
	
	@test( "Test 'isRegistered' behavior" )
    public function testIsRegistered() : Void
    {
		Assert.assertMethodCallThrows( UnsupportedOperationException, this._dispatcher.isRegistered, [ this._listener ], "isRegistered should throw UnsupportedOperationException" );
    }
	
	@test( "Test 'hasEventListener' behavior" )
    public function testHasEventListener() : Void
    {
        this._dispatcher.addEventListener( "onEvent", this._listener.onEvent );
        Assert.assertTrue( this._dispatcher.hasEventListener( "onEvent" ), "'hasEventListener' should return true" );
        Assert.assertTrue( this._dispatcher.hasEventListener( "onEvent", this._listener.onEvent ), "'hasEventListener' should return true" );
        Assert.failTrue( this._dispatcher.hasEventListener( "onAnotherEvent" ), "'hasEventListener' should return false" );
        Assert.failTrue( this._dispatcher.hasEventListener( "onAnotherEvent", ( new MockEventListener() ).onEvent ), "'hasEventListener' should return false" );
    }
}

private class MockEventListener
{
    public var eventReceivedCount : Int = 0;
    public var lastEventReceived : BasicEvent = null;

    public function new()
    {

    }

    public function onEvent( e : BasicEvent ) : Void
    {
        this.eventReceivedCount++;
        this.lastEventReceived = e;
    }
}