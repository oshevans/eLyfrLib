package uk.co.moilin.eLyfrLib.data
{
	import mx.charts.chartClasses.Series;

	/**
	 * Contains all data for the series of books 
	 * @author oevans
	 * 
	 */
	public class SeriesData
	{
		private var _title:String;
		public function get title():String { return _title };

		private var _logo:String;
		public function get logo():String { return _logo };

		private var _themeStyles:ThemeStyles
		public function get themeStyles():ThemeStyles { return _themeStyles };

		private var _infoText:String;
		public function get infoText():String { return _infoText };

		private var _books:Array;
		public function get books():Array { return _books };

		
		public function SeriesData(rawData:XML)
		{
			_title = rawData.title;
			_logo = rawData.logo;
//			_themeStyles = new ThemeStyles(rawData.themeStyles);
			_infoText = rawData.infoText;
			_books = new Array();
			for each (var book:XML in rawData.books.book)
			{
				books.push(new BookData(book));
			}
		}
	}
}