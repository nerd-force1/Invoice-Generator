#ifndef EMBOINVOICEDATA_H
#define EMBOINVOICEDATA_H

#include<string>
#include<vector>
#include<chrono>

namespace emBO{

    struct recipient_t{
        std::string company;
        std::string name;
        std::string address;
        std::string addressAdditional;
        std::string postal;
        std::string city;
        std::string country;

        enum language{german, english};
    };

    struct item_t{

    };


    typedef std::vector<item_t> items_t;

    class emBOInvoiceData
    {
    public:
        recipient_t recipient;
        items_t positions;
        std::string invoicePrefix{"NF1"};
        std::chrono::system_clock::time_point invoiceTime;
        long invoiceNumber;

        emBOInvoiceData();

    };

}

#endif // EMBOINVOICEDATA_H
