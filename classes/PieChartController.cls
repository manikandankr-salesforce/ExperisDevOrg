public class PieChartController {

    public List<PieWedgeData> getPieData() {

        List<PieWedgeData> data = new List<PieWedgeData>();

        data.add(new PieWedgeData('Cus1', 30));

        data.add(new PieWedgeData('Cus2', 15));

        data.add(new PieWedgeData('Cus3', 10));

        data.add(new PieWedgeData('Cus4', 20));

        data.add(new PieWedgeData('Cus5', 20));

        data.add(new PieWedgeData('Cus', 5));

        return data;

    }

    // Wrapper class

    public class PieWedgeData {

 

        public String name { get; set; }

        public Integer data { get; set; }

 

        public PieWedgeData(String name, Integer data) {

            this.name = name;
            this.data = data;

        }

    }

}