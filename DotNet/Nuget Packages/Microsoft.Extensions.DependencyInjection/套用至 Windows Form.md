# 套用至 Windows Form

1. 方式

   ```csharp
   [STAThread]
   static void Main()
   {
       Application.EnableVisualStyles();
       Application.SetCompatibleTextRenderingDefault(false);

       var serviceProvider = BuildDIServiceProvider();
       Application.Run(serviceProvider.GetService<Form1>());
   }

   private static IServiceProvider BuildDIServiceProvider()
   {
       var services = new ServiceCollection();
       services.AddSingleton<Form1>();
       services.AddTransient<ExcelMiddleware>();

       var serviceProvider = services.BuildServiceProvider();
       return serviceProvider;
   }
   ```

2. 方式

   ```csharp
   [STAThread]
   static void Main()
   {
       Application.EnableVisualStyles();
       Application.SetCompatibleTextRenderingDefault(false);

       Application.Run(new DiFactory().GetService<Form1>());
   }

   public class DiFactory
   {
       private static readonly ServiceProvider _serviceProvider;

       static DiFactory()
       {
           var services = new ServiceCollection();
           services.AddTransient<MainWindow>();
           services.AddSingleton<DiFactory>(x => new DiFactory());

           services.AddBusinessLogicLayer();
           _serviceProvider = services.BuildServiceProvider();
       }

       public T GetService<T>()
       {
           return _serviceProvider.GetService<T>();
       }
   }
   ```
