package mockDomain
{
	import TradingApi.Client.Core.Domain.Price;
	
	public class PriceBuilder
	{
        public var MarketId:int = 12345;
		public var TickDate:Date;
        public var PriceValue:Number = 10.5;
        /// <summary>
        /// Default: 2010-02-22 09:48:44
        /// </summary>
        public var LastUpdateTime:Date = new Date(2010,02,22,09,48,44);
        public var Indicative:Boolean = true;

        public function Build():Price
        {
            var newPrice:Price = new Price();

			newPrice.MarketId = MarketId;
			newPrice.TickDate = TickDate;
			newPrice.PriceValue = PriceValue;
			            
            return newPrice;
        }

//        public LightstreamerEventArgs<StreamingUpdate> CreateMockStreamingUpdateForPrice(Price price)
//        {
//            var args = new LightstreamerEventArgs<StreamingUpdate>();
//            args.Item = new StreamingUpdate();
//            args.Item.ItemName = string.Format("price.{0}", price.MarketId);
//            args.Item.ItemPosition = 1;
//            args.Item.Update = MockRepository.GenerateMock<UpdateDetails>();
//            args.Item.Update.Expect(x => x.GetAsLong(Indices.Price.MarketId)).Return(price.MarketId);
//            args.Item.Update.Expect(x => x.GetAsDecimal(Indices.Price.Bid)).Return(price.Bid);
//            args.Item.Update.Expect(x => x.GetAsDecimal(Indices.Price.Offer)).Return(price.Offer);
//            args.Item.Update.Expect(x => x.GetAsInt(Indices.Price.Direction)).Return(price.Direction);
//            args.Item.Update.Expect(x => x.GetAsDecimal(Indices.Price.Change)).Return(price.Change);
//            args.Item.Update.Expect(x => x.GetAsString(Indices.Price.AuditId)).Return(price.AuditId);
//            args.Item.Update.Expect(x => x.GetAsDecimal(Indices.Price.Delta)).Return(price.Delta);
//            args.Item.Update.Expect(x => x.GetAsDecimal(Indices.Price.ImpliedVolatility)).Return(price.ImpliedVolatility);
//            args.Item.Update.Expect(x => x.GetAsDateTime(Indices.Price.LastUpdateTime)).Return(price.LastUpdateTime);
//            args.Item.Update.Expect(x => x.GetAsBool(Indices.Price.Indicative)).Return(price.Indicative);
//            return args;
//        }
    }

}