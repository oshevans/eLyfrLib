package uk.co.moilin.eLyfrLib.data
{
	import mx.charts.chartClasses.Series;

	public class SeriesData
	{
		public var title:String;
		public var logo:String;
		public var themeStyles:ThemeStyles
		public var infoText:String;
		public var books:Array;
		
		public function SeriesData(rawData:XML)
		{
			title = rawData.title;
			logo = rawData.logo;
//			themeStyles = new ThemeStyles(rawData.themeStyles);
			infoText = rawData.infoText;
			books = new Array();
			for each (var book:XML in rawData.books.book)
			{
				books.push(new BookData(book));
			}
		}
	}
}