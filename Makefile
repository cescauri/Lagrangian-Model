F90 = mpif90
CXX = mpicxx

INCS = -I$(HOME)/Itzamna/src/liggghts-nrl/src \
       -I$(HOME)/Itzamna/install/include -I$(BOOST_ROOT)/include

LIBS = -L$(HOME)/Itzamna/src/liggghts-nrl/src \
       -L$(HOME)/Itzamna/install/lib -L$(BOOST_ROOT)/lib \
       -llammps_crc \
       -lboost_mpi -lboost_serialization -lsphereslice -lstdc++

#FLAGS = -g -O3 -fPIC
#FFLAGS = $(INCS) $(FLAGS) -fdefault-real-8
FLAGS = -g -O2 -fPIC
FFLAGS = $(INCS) $(FLAGS) -r8 -i4 -assume byterecl
CXXFLAGS = $(INCS) $(FLAGS)
LDFLAGS = $(LIBS) $(FLAGS)

OBJS = LAMMPS.o LAMMPS-wrapper.o fft.o les.o

EXE = itzamna

all: $(EXE)

$(EXE): $(OBJS)
	$(F90) -o $@ $+ $(LDFLAGS)

LAMMPS-wrapper.o: LAMMPS-wrapper.cpp
	$(CXX) -c -o $@ $+ $(CXXFLAGS)

LAMMPS.o: LAMMPS.F90
	$(F90) -c -o $@ $+ $(FFLAGS)

fft.o: fft.f
	$(F90) -c -o $@ $+ $(FFLAGS)

les.o: les.F
	$(F90) -c -o $@ $+ $(FFLAGS)

clean:
	rm -f *.mod *.o $(EXE)
