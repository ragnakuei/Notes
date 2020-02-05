# RabbitMQ

- [RabbitMQ](#rabbitmq)
  - [安裝套件](#%e5%ae%89%e8%a3%9d%e5%a5%97%e4%bb%b6)
  - [程式](#%e7%a8%8b%e5%bc%8f)
    - [自制 RabbitMqService](#%e8%87%aa%e5%88%b6-rabbitmqservice)
    - [使用語法](#%e4%bd%bf%e7%94%a8%e8%aa%9e%e6%b3%95)

---

## 安裝套件

> Install-Package RabbitMQ.Client

---

## 程式

[範例](https://github.com/ragnakuei/RabbitMqSample01)

### 自制 RabbitMqService

```csharp
public class RabbitMqService : IDisposable
{
    /// <summary>
    /// 發送訊息
    /// </summary>
    public void BasicPublish( string           exchange,
                                string           routingKey,
                                IBasicProperties basicProperties,
                                string           body )
    {
        // Declaring a queue is idempotent 
        Channel.BasicPublish( exchange : exchange,
                                routingKey : routingKey,
                                basicProperties : basicProperties,
                                body : Encoding.UTF8.GetBytes( body ) );
    }

    /// <summary>
    /// 設定收到訊息後的動作
    /// </summary>
    public void SetReceivedAction( Action<BasicDeliverEventArgs> action )
    {
        //接收到消息事件
        Consumer.Received += ( ch, ea ) =>
        {
            action( ea );

            //确认该消息已被消费
            Channel.BasicAck( ea.DeliveryTag, false );
        };
    }

    /// <summary>
    /// 開始讀取訊息
    /// </summary>
    public void BasicConsume( string routingKey, bool autoAck )
    {
        Channel.BasicConsume( routingKey, autoAck, Consumer );
    }

    private ConnectionFactory _connectionFactory => new ConnectionFactory()
    {
        HostName                   = "localhost",
        UserName                   = "guest",
        Password                   = "guest",
        Port                       = 5672,
        RequestedConnectionTimeout = 3000, // milliseconds
    };

    private IConnection _rabbitConnection;

    public IConnection RabbitConnection
    {
        get
        {
            if ( _rabbitConnection == null )
            {
                _rabbitConnection = _connectionFactory.CreateConnection();
            }

            return _rabbitConnection;
        }
    }

    private IModel _channel;

    public IModel Channel
    {
        get
        {
            if ( _channel == null )
            {
                _channel = RabbitConnection.CreateModel();
            }

            return _channel;
        }
    }

    private EventingBasicConsumer _consumer;

    public EventingBasicConsumer Consumer
    {
        get
        {
            if ( _consumer == null )
            {
                _consumer = new EventingBasicConsumer( Channel );
            }

            return _consumer;
        }
    }

    public void Dispose()
    {
        _rabbitConnection?.Dispose();
        _channel?.Dispose();
    }
}
```

### 使用語法

```csharp
class Program
{
    static async Task Main( string[] args )
    {
        var rabbitMqService = new RabbitMqService();

        Console.WriteLine( @"
A) 發送訊息
B) 接收訊息
" );
        var inputKey = Console.ReadKey();

        try
        {
            switch ( inputKey.Key )
            {
                case ConsoleKey.A:
                    Console.WriteLine( "持續發送訊息中 ..." );
                    while ( true )
                    {
                        string body = $"A nice random message: {DateTime.Now.Ticks}";

                        rabbitMqService.BasicPublish( exchange : string.Empty,
                                                        routingKey : "testqueue",
                                                        basicProperties : null,
                                                        body );

                        Console.WriteLine( "Message sent" );
                        await Task.Delay( 500 );
                    }

                    break;
                case ConsoleKey.B:
                    Console.WriteLine( "持續接收訊息中，按下任一鍵停止 ..." );
                    rabbitMqService.SetReceivedAction( ( BasicDeliverEventArgs ea ) =>
                    {
                        var message = Encoding.UTF8.GetString( ea.Body );
                        Console.WriteLine( $"收到消息： {message}" );
                    } );

                    rabbitMqService.BasicConsume( "testqueue", false );

                    Console.ReadKey();
                    break;
            }
        }
        catch ( Exception ex )
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine( ex.ToString() );
            Console.ForegroundColor = ConsoleColor.White;
        }

        Console.WriteLine( "End" );
    }
}
```

