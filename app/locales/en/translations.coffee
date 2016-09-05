Translations = {
  brand:
    link: 'WS-RS'
  home:
    link: 'Home'
    title: 'WS-RS'
    tag: 'Lightweight, event-driven WebSockets for Rust'
    about:
      header: 'About'
      content: "This library provides an implementation of WebSockets (RFC6455) in <a target='_blank' href='https://www.rust-lang.org/'>Rust</a>.
        WS-RS uses <a target='_blank' href='https://github.com/carllerche/mio'>MIO</a> to leverage asynchronous IO to allow for handling multiple
        WebSocket connections on a single thread. WS-RS embraces the bidirectional nature of WebSockets allowing for both client
        and server connections to coexist as part of one WebSocket component. The WS-RS"
      apiLink: 'API'
      afterApiLink: "aims to keep simple WebSocket applications simple and make advanced WebSocket programming possible in
        <a target='_blank' href='https://www.rust-lang.org/'>Rust</a> by abstracting away the menial parts of the WebSocket protocol while still
        providing enough low-level access to allow for custom extensions and subpotocols. For example, WS-RS supports the"
      deflateLink: 'permessage-deflate extension'
      afterDeflateLink: 'as an optional feature. This library also supports SSL encrypted websockets using the'
      sslLink: 'ssl feature'
      afterSslLink: '. WS-RS is regularly'
      testLink: 'tested'
      afterTestLink: 'and there are several'
      examplesLink: 'examples'
      afterExamplesLink: 'demonstrating various tasks that can be solved with WebSockets. Make sure to check out the'
      guideLink: 'guide'
      afterGuideLink: "to help get started. The documentation is also available as a static page <a target='_blank' href='https://ws-rs.org/api_docs/ws/index.html'>here</a>."

    benchmark:
      header: 'Comparison with other WebSocket libraries'
      intro: "You don't need to use this library to the exclusion of other WebSocket libraries, in Rust or other languages,
        but if you find yourself considering which library to use: choose the one that has the API you like the most.
        The API is generally more important than performance. The library API is what you will have to deal with as
        you build your WebSocket application. The design of WS-RS aims to provide a clean, consistent API. If you identify possible improvements
        please make a <a target='_blank' href='https://github.com/housleyjk/ws-rs/issues'>feature request</a>."
      value: "However, if performance is what you value most and you want a WebSocket library in Rust please consider WS-RS.
        Here is how it stacks up against some other common frameworks using the example
        <a target='_blank' href='https://github.com/housleyjk/ws-rs/tree/stable/examples/bench.rs'>benchmark tool</a>
        to open 10,000 simultaneous connections and send 10 messages. These results are <strong>not</strong> reliable as a serious benchmark:"
      library: 'Library'
      time: 'Time (ms)'
      wsrs:
        link: "<a href='#'>WS-RS</a>"
        time: '1,709'
      libwebsockets:
        link: "<a target='_blank' href='https://libwebsockets.org/trac/libwebsockets'>libwebsockets</a>"
        time: '2,067'
      rustwebsocket:
        link: "<a target='_blank' href='https://github.com/cyderize/rust-websocket'>rust-websocket</a>"
        time: '8,950'
      websockets:
        link: "<a target='_blank' href='http://aaugustin.github.io/websockets/'>* websockets CPython 3.4.3</a>"
        time: '12,638'
        events: '* websockets encountered a few (3) broken pipe errors'
      autobahn:
        link: "<a target='_blank' href='http://autobahn.ws/python/'>Autobahn CPython 2.7.10</a>"
        time: '48,902'
      node:
        link: "<a target='_blank' href='https://github.com/websockets/ws'>** NodeJS via ws</a>"
        time: '127,635'
        events: '** NodeJS encountered several (229) connection timeout errors'
      disclaimer: "Your results will vary. The system specs for this test were as follows:
        Intel(R) Core(TM) i3 CPU 560 @ 3.33GHz, 8GB RAM"

  guide:
    title: 'Guide'
    trigger: 'Guide'
    link: 'Getting Started'
    header: 'Getting Started'
    install:
      header: 'Installation'
      instructions: 'To start using WS-RS simply add it to your <code>Cargo.toml</code> file.'
      explanation: 'Using <code>"*"</code> will give you the latest stable version. If you want the development version, link to the master branch of the WS-RS respository.'
    usage:
      header: 'Usage'
      simple: "For simple applications, use one of the utility functions <code>listen</code> and <code>connect</code>:<br><br>
        <code>listen</code> accepts a string representation of a socket address and a <code>Factory</code>."
      clientSimple: "<code>connect</code> accepts a string that represents a WebSocket URL (i.e. one that starts with ws:// or wss://),
        and it will attempt to connect to a WebSocket server at that location. It also accepts a <code>Factory</code>."
      explanation: "Each of these functions encapsulates a mio EventLoop, creating and running a WebSocket in the
        current thread. These are blocking functions, so they will only return after the encapsulated
        WebSocket has been shutdown."
    architecture:
      link: 'Architecture'
      title: 'Architecture'
      header: 'Architecture'
      p1: "A WebSocket requires two basic components: a Factory and a Handler. A Factory is any struct
        that implements the <code>Factory</code> trait. WS-RS already provides an implementation of <code>Factory</code> for
        closures that take a <code>Sender</code> as the first argument, so it is possible to pass a closure as a
        Factory to either of the utility functions.
        Your Factory will be called each time the underlying TCP connection has been successfully
        established, and it will need to return a Handler that will handle the new WebSocket connection."
      p2: "Factories can be used to manage state that applies to multiple WebSocket connections,
        whereas Handlers manage the state of individual connections. Most of the time, a closure
        Factory is sufficient, and you will only need to focus on writing your Handler.
        Your Factory will be passed a <code>Sender</code> struct that represents the output of the WebSocket.
        The Sender allows the Handler to send messages, initiate a WebSocket closing handshake
        by sending a close code, and other useful actions. If you need to send messages from other parts
        of your application it is possible to clone and send the Sender across threads allowing
        other code to send messages on the WebSocket without blocking the event loop."
      p3: "Just as with the Factory, it is possible to use a closure as a simple Handler. The closure must
        take a <code>Message</code> as it's only argument, and it may close over variables that exist in
        the Factory. For example, in getting started examples with <code>listen</code> and <code>connect</code>, the closure
        Factory returns another closure as the Handler for the new connection. This handler closure closes over
        the variable <code>out</code>, which is the Sender, representing the output of the WebSocket, so that it
        can use that sender later to send a Message. Closure Handlers generally need to take ownership of the variables
        that they close over because the Factory may be called multiple times. Think of Handlers as
        though they were running on separate threads and they should make sense within Rust's memory model. Closure Handlers must return
        a <code>Result&lt;()&gt;</code>, in order to handle errors without panicking."
      p4: "Sender methods, such as <code>close</code> and <code>send</code> both actually return a <code>Result&lt;()&gt;</code> indicating
        whether they were able to schedule the requested command (either <code>close</code> or <code>send</code>) with the
        EventLoop."
      p5: "<em>It is important that your Handler does not panic carelessly because a handler that panics will
        disconnect every other connection that is using that WebSocket. Don't panic unless you want all
        connections to immediately fail.</em>"
    impl:
      header: 'Implementing a Handler'
      intro: "You may have noticed in the usage examples that the client example calls <code>unwrap</code> when sending the first
        message, which will panic in the factory if the Message can't be sent for some reason. Also,
        sending messages before a handler is returned means that the message will be queued before
        the WebSocket handshake is complete. The handshake could fail for some reason, and then the
        queued message would be wasted effort. Sending messages in the Factory is not bad for simple,
        short-lived, or toy projects, but let's explore writing a handler that is better for
        long-running applications. In order to solve the problem of sending a message immediately when a WebSocket connection is
        established, you will need to write a Handler that implements the <code>on_open</code> method. For
        example:"
      complexity: "That is a big increase in verbosity in order to accomplish the same effect as the
        original example, but this way is more flexible and gives you access to more of the underlying
        details of the WebSocket connection."
      onOpen: "It's also important to note that using <code>on_open</code> allows you to tie in to the lifecycle of the
        WebSocket. If the opening handshake is successful and <code>on_open</code> is called, the WebSocket is now
        open and alive. Until that point, it is not guaranteed that the connection will be
        upgraded. So, if you have important state that you need to tear down, or if
        you have some state that tracks closely the lifecycle of the WebScoket connection, it is best to
        set that up in the <code>on_open</code> method rather than when your handler is first created.
        If <code>on_open</code> returns Ok, then you are guaranteed that <code>on_close</code> will run when the WebSocket
        connection is about to go down, unless a panic has occurred."
      onClose: "Therefore you will probably want to implement <code>on_close</code>. This method is called anytime
        the WebSocket connection will close. The <code>on_close</code> method implements the closing handshake of
        the WebSocket protocol. Using <code>on_close</code> gives you a mechanism for informing the user regarding
        why the WebSocket connection may have been closed even if no errors were encountered.
        It also gives you an opportunity to clean up any resources or state that may be dependent on the
        connection that is now about to disconnect. An example server might use this as follows: "
      onError: "When errors occur, your handler will be informed via the <code>on_error</code> method. Depending on the
        type of the error, the connection may or may not be about to go down. If the error is such that
        the connection needs to close, your handler's <code>on_close</code> method will be called and WS-RS will
        send the appropriate close code to the other endpoint if possible. A server that tracks state related to the life of the WebSocket connection
        and informs the user of errors might be as follows:"
      other: "There are other Handler methods that allow even more fine-grained access, but most applications
        will usually only need these four methods."

    ssl:
      title: 'SSL'
      header: 'SSL Feature'
      link: 'SSL'
      intro: "WS-RS supports WebSocket connections using SSL (e.g. `wss://my/secure/websocket`).
        To enable the ssl feature, require WS-RS in your <code>Cargo.toml</code> with the feature listed:"
      usage: 'With the ssl feature enabled, you can connect to an encrypted socket by using the <code>wss</code> scheme.'
    deflate:
      title: 'deflate'
      link: 'permessage-deflate'
      header: 'Deflate Extension'
      intro: "WS-RS supports the <a target='_blank' href='https://tools.ietf.org/html/rfc7692'>permessage-deflate extension</a>
        which allows for the compression of WebSocket messages. To enable the feature, specify it in your <code>Cargo.toml</code>:"
      usage: "Once the feature is enabled, you will need to wrap your message handler inside of a <code>DeflateHandler</code>, which
        will negotiate the extension with the other endpoint and perform the compression and decompression of messages."
      settings: "The <code>DeflateHandler</code> will accept any other valid handler. In other words, any struct that implements
        the <code>Handler</code> trait. If you would like to configure the extension, for example if you wanted to limit the size
        of the sliding window, use the <code>DeflateBuilder</code> struct and pass in the settings."
  docs:
    link: 'API Documentation'
    title: 'Documentation'
  testing:
    trigger: 'Tests'
    rust:
      link: 'Built-in Rust Tests'
      header: 'Testing'
      title: 'Tests'
      intro: "WS-RS is well-maintained and tested with the use of Rust's
        built-in support for unit testing and integration testing. To run the tests,
        clone the latest code and use Cargo to run the tests:"
      featureTests: " You can can run the tests with various features active like so:"
      examples: "For examples of how you can write your own integration tests, checkout the
        <a target='_blank' href='https://github.com/housleyjk/ws-rs/blob/master/tests/shutdown.rs'>shutdown test</a>."
    autobahn:
      link: 'Autobahn Test Suite'
      linkBegin: "In addition to the built-in Rust tests, WS-RS also passes the complete"
      title: 'Autobahn'
      header: 'Autobahn Test Suite'
    results:
      title: 'Autobahn Results'
      link: 'Latest Autobahn Test Results'
      header: 'Autobahn Test Suite Latest Results'
      server: 'Server'
      client: 'Client'
      legend:
        header: 'Legend'
        ok: 'Ok'
        failed: 'Failed'
        inform: 'Informational'
        unimplemented: 'Unimplemented'
        'non-strict': 'Non-Strict'
  repository:
    link: 'Code'
  examples:
    link: 'Examples'
    header: 'Examples'
    title: 'Examples'
    server:
      link: 'Server'
      description: 'A simple WebSocket echo server using closures.'
    client:
      link: 'Client'
      description: 'A simple WebSocket client for connecting to an echo server using closures.'
    shared:
      link: 'Single-Threaded'
      description: 'An example of an echo client and an echo server on one thread using closures.'
    threaded:
      link: 'Threads'
      description: "An example of an echo client and an echo server on separate threads.
        This demonstrates using a struct as a WebSocket handler."
    channel:
      link: 'Channels'
      description: "A more complex example using channels to communicate with a
        WebSocket handler to accomplish a separate task."
    pong:
      link: 'Pong'
      description: 'An example demonstrating how to send and recieve a custom ping/pong frame.'
  chat:
    link: 'Chat Log'
    message: 'Message'
    nick: 'Nickname'
    join: 'Join'
    example: 'Live Chat Example'
  notFound:
    header: 'Page Not Found'
    explanation: 'The page you requested could not be found. Please try one of these:'
  loading: 'Loading...'

}
`export default Translations`
